require 'spec_helper'

describe 'Survey tasks' do
  let(:record) do
    {
      "source"=>"panoptes",
      "type"=>"classification",
      "version"=>"1.0.0",
      "timestamp"=>"2016-02-29T11:08:09Z",
      "data"=>{
        "id"=>"10178550",
        "created_at"=>"2016-02-29T11:08:08.857Z",
        "updated_at"=>"2016-02-29T11:08:08.926Z",
        "user_ip"=>"82.151.36.14",
        "annotations"=>[{"task"=>"T0", "value"=>[{"choice"=>"DR", "answers"=>{"DLTNTLRLSS"=>"1"}, "filters"=>{}}]}], 
        "metadata"=>{
          "session"=>"123", 
          "viewport"=>{"width"=>1366, "height"=>643}, 
          "started_at"=>"2016-02-29T11:08:23.086Z", 
          "user_agent"=>"Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/48.0.2564.116 Safari/537.36",
          "utc_offset"=>"-3600",
          "finished_at"=>"2016-02-29T11:08:32.072Z",
          "live_project"=>true,
          "user_language"=>"en",
          "user_group_ids"=>[], 
          "subject_dimensions"=>[{"clientWidth"=>772, "clientHeight"=>579, "naturalWidth"=>2048, "naturalHeight"=>1536}], 
          "workflow_version"=>"325.11"
        },
        "href"=>"/classifications/10178550",
        "links"=>{"project"=>"1453", "user"=>"1538", "workflow"=>"1590", "subjects"=>["1621039"]}
      }, 
      "linked"=>{
        "subjects"=>[{
          "id"=>"1621039", 
          "metadata"=>{"Name"=>"APOS00000000007460C.jpg", "Collection"=>"Pilot A1", "Description"=>"NW Wisconsin"}, 
          "created_at"=>"2016-02-18T21:21:27.148Z", 
          "updated_at"=>"2016-02-18T21:21:27.148Z", 
          "href"=>"/subjects/1621039"
        }]
      }
    }
  end

  let(:storage)   { Warehouse::Storage.new(DB) }
  let(:processor) { Warehouse::Processor.new(storage) }

  it 'processes' do
    processor.process(record)

    expect(DB[:classifications].count).to eq(1)
    binding.pry
  end
end
