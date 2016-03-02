require 'spec_helper'

describe 'Drawing tasks' do
  let(:record) do
    {
      "source"=>"panoptes", 
      "type"=>"classification", 
      "version"=>"1.0.0", 
      "timestamp"=>"2016-02-29T11:02:46Z", 
      "data"=>{
        "id"=>"10178511", 
        "created_at"=>"2016-02-29T11:02:46.353Z", 
        "updated_at"=>"2016-02-29T11:02:46.411Z", 
        "user_ip"=>"127.0.0.1", 
        "annotations"=>[
          {"task"=>"T1", "value"=>0}, 
          {"task"=>"T2", "value"=>[
            {
              "tool"=>0,
              "frame"=>0, 
              "closed"=>true,
              "points"=>[
                {"x"=>143.2045287510176, "y"=>55.03589970175632}, 
                {"x"=>358.45606536409394, "y"=>59.92797967524577}, 
                {"x"=>574.9306220715628, "y"=>66.04307964210759}, 
                {"x"=>578.5996823547403, "y"=>281.2945984756434}, 
                {"x"=>363.34814574166387, "y"=>271.5104385286645}, 
                {"x"=>144.42754884541006, "y"=>270.28741853529215}
              ], 
              "details"=>[]
            }
          ]}, 
          {"task"=>"T3", "value"=>[
            {"x"=>422.0531102725028, "y"=>212.8054788467911, "tool"=>2, "frame"=>0, "details"=>[]}, 
            {"x1"=>239.82311620802346, "x2"=>270.39861856783546, "y1"=>99.06461946316138, "y2"=>97.84159946978902, "tool"=>0, "frame"=>0, "details"=>[]}, 
            {"x1"=>386.58552753512095, "x2"=>429.3912308388577, "y1"=>228.7047387606318, "y2"=>229.9277587540042, "tool"=>0, "frame"=>0, "details"=>[]}, 
            {"x1"=>195.7943928098942, "x2"=>222.70083488652875, "y1"=>226.2586987738871, "y2"=>227.48171876725945, "tool"=>0, "frame"=>0, "details"=>[]}
          ]}
        ], 
        "metadata"=>{
          "session"=>"asdf", 
          "viewport"=>{"width"=>1097, "height"=>629}, 
          "started_at"=>"2016-02-29T11:00:34.940Z", 
          "user_agent"=>"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/48.0.2564.116 Safari/537.36", 
          "utc_offset"=>"18000", 
          "finished_at"=>"2016-02-29T11:02:44.785Z", 
          "live_project"=>true, 
          "user_language"=>"en", 
          "user_group_ids"=>[], 
          "subject_dimensions"=>[{"clientWidth"=>572, "clientHeight"=>283, "naturalWidth"=>700, "naturalHeight"=>346}], 
          "workflow_version"=>"137.203"
        }, 
        "href"=>"/classifications/10178511", 
        "links"=>{"project"=>"153", "user"=>"123", "workflow"=>"125", "subjects"=>["1641047"]}
      }, 
      "linked"=>{
        "subjects"=>[{
          "id"=>"1641047", 
          "metadata"=>{"#Col"=>"2", "#Row"=>"2", "Filename"=>"R1066358_c_2_2.jpg"}, 
          "created_at"=>"2016-02-22T21:26:08.448Z", 
          "updated_at"=>"2016-02-22T21:26:08.448Z", 
          "href"=>"/subjects/1641047"
        }]
      }
    }
  end
  
end
