# Put this file in the root of your git repository then run `ruby blame.rb`.
# You will need gsed. You can install gsed with `brew install gsed`.
# Crazy shell script taken from http://stackoverflow.com/questions/4589731/git-blame-statistics

input = `git ls-tree -r HEAD|gsed -re 's/^.{53}//'|while read filename; do file "$filename"; done|grep -E ': .*text'|gsed -r -e 's/: .*//'|while read filename; do git blame "$filename"; done|gsed -r -e 's/.*\\((.*)[0-9]{4}-[0-9]{2}-[0-9]{2} .*/\\1/' -e 's/ +$//'|sort|uniq -c`

aggregated = {}
input.lines.each do |line|
  line.strip!
  
  count = 0
  person = "Unknown"
  
  # Extract
  if matches = line.match(/^([0-9]+)\s(.*)$/)
    count = matches[1].to_i
    first_name, last_name = matches[2].split
    
    if first_name and first_name[0].match(/[a-zA-z]/)
      person = first_name
      
      if last_name and last_name[0].match(/[a-zA-z]/)
        person += " #{last_name}"
      end
    end
    
  end
  
  # Add to aggregation
  unless aggregated[person]
    aggregated[person] = 0
  end  
  aggregated[person] += count.to_i
end

aggregated.each do |person, count|
  puts "#{person}\t #{count}"
end
