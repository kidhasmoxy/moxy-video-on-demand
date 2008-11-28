class Library < ActiveRecord::Base
  has_many :videos

  def build_library
    MiddleMan(:library_worker).enq_build_library(:arg => (id), :job_key = "library_#{id}")
    return true
  end
end
