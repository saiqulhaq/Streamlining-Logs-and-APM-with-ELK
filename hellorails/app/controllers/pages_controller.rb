class PagesController < ApplicationController
  def home
    ElasticAPM.with_span "Heavy work" do
      sleep rand(0.1..2.0)
      puts "Heavy work done"
    end
    ElasticAPM.with_span "Heavy work 2" do
      sleep rand(0.1..2.0)
      puts "Heavy work 2 done"
    end
    ElasticAPM.with_span "Heavy work 3" do
      sleep rand(0.1..2.0)
      puts "Heavy work 3 done"
    end
  end
end
