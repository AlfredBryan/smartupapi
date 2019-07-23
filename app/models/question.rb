class Question < ApplicationRecord
  belongs_to :topic, optional: true

  has_many :answers, dependent: :destroy
  has_many :maximum_scores
  # has_many :comments, dependent: :destroy

  QUESTION_TYPES = %w(choice theory)

  has_many :answer_options, dependent: :destroy
  has_many :assessment_questions, dependent: :destroy

  validates :name, :description, presence: true
  validates :question_type, presence: true, inclusion: { in: QUESTION_TYPES }

  validate :theory_question?

  scope :theory, -> { where(question_type: "theory") }
  scope :choice, -> { where(question_type: "choice") }

  def theory?
    (question_type == "theory") && answer_options.none?
  end

  def choice?
    (question_type == "choice")
  end

  def theory_question?
    errors.add(:question_type, "Remove all answer options to make this a theory question!") if answer_options.any?
  end

  def max_score(assessment_id)
    maximum_scores.find_by(assessment_id: assessment_id).score
  rescue
    0.0
  end

  def self.from_csv(file)
    csv_text = File.read("db/imports/#{file}")
    csv = CSV.parse(csv_text, headers: true, quote_char:'"', col_sep:",")
    csv.each_with_index do |entry, idx|
      break if idx > 100
      entry = entry.to_h
      name = "Economics Question #{idx + 1}"
      desc = entry['QUESTIONS']
      question_type = "choice"
      options = []
      bets = ["a", "b", "c", "d", "e"]
      correct = entry["CORRECT ANSWER"]
      bets.each { |bet| options << entry["OPTION #{bet.upcase}"] }
      question = Question.create(name: name, description: desc, question_type: question_type)
      options.each { |opt| question.answer_options.create!(content: opt, correct: (options[bets.index(correct.downcase)] == opt)) } if question.persisted?
    end
  end

  def self.import(file, topic_id=nil)
    CSV.foreach(file.path, headers: true) do |row|
      options = []
      bets = ["a", "b", "c", "d", "e"]
      correct = nil
      question_hash = {}
      question_hash[:topic_id] = topic_id
      row.to_hash.each_pair do |k,v|
        correct = v if k.to_s == "CORRECT ANSWER"
        options << v if k.to_s.downcase.include?("option")
        question_hash.merge!({k.to_s.downcase.to_sym => v}) if Question.new.attributes.keys.include?(k.downcase.to_s)
      end
      question = Question.create!(question_hash)
      options.each { |opt| question.answer_options.create!(content: opt, correct: (options[bets.index(correct.to_s.downcase)] == opt)) } if question.persisted? && question.choice?
    end
  end
end
