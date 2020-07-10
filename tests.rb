require_relative 'lib/main.rb'

begin
  p FFlogs::Zones.zones()
  p FFlogs::Classes::classes()
  p FFlogs::Rankings::encounter(encounterID:32)
  p FFlogs::Rankings::character(characterName:"Rin Hoshizora", serverName:"Exodus", serverRegion:"NA")
  p FFlogs::Parses::character(characterName:"Rin Hoshizora", serverName:"Exodus", serverRegion:"NA")
  p FFlogs::Reports.guild(guildName:"Wild Hearts", serverName:"Exodus", serverRegion:"NA")
  p FFlogs::Reports.user(username:"wesleylucas")
rescue RestClient::ExceptionWithResponse => err
  p JSON.parse(err.response.body)
end
