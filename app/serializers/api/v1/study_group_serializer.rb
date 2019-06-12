class Api::V1::StudyGroupSerializer < Api::V1::ApplicationSerializer
  attributes :name, :level, :members
end
