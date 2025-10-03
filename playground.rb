require 'json'
puts ".....loading"
load = {"authenticity_token"=>"[FILTERED]", "level"=>{"data"=>"{\"id\":540,\"title\":null,\"created_at\":\"2025-08-29T00:04:54.631+01:00\",\"updated_at\":\"2025-08-29T00:04:54.631+01:00\",\"degree\":\"development\",\"category\":\"information_management\",\"step\":\"four\"}", "checklists"=>{"2459"=>"1", "2460"=>"1", "2461"=>"1", "2462"=>"1", "2463"=>"1"}}, "user_ids"=>"54", "commit"=>"Assign KPIs"}
data = JSON.parse(load)


puts data