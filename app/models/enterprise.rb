class Enterprise < ActiveRecord::Base
	include Country
	has_many :departments, :inverse_of => :enterprise
	has_many :request_types, :inverse_of => :enterprise
	has_one  :range_employee

	validates :empresa, presence: true, length: { maximum: 100 }, uniqueness: { case_sensitive: false}
	validates :country, presence: true
	accepts_nested_attributes_for :departments



	def self.with_range_stats
	    query = <<-SQL
	       SELECT
		        CASE
		            WHEN (a.empleados < 10) THEN '<10'::text
		            WHEN (a.empleados < 26) THEN '10-25'::text
		            WHEN (a.empleados < 51) THEN '26-50'::text
		            WHEN (a.empleados < 101) THEN '51-100'::text
		            ELSE '>100'::text
		        END AS range_employees,
		    a.empleados,
		    a.empresa
		   FROM ( SELECT count(*) AS empleados,
		            e.empresa
		           FROM ((enterprises e
		             JOIN departments dpto ON ((e.id = dpto.enterprise_id)))
		             JOIN employees emp ON ((emp.department_id = dpto.id)))
		          GROUP BY e.id) a
	    SQL

	    self.find_by_sql(query)
  end
end
