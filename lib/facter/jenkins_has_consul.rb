Facter.add("jenkins_has_consul") do
  confine :kernel => 'Linux'
  setcode do
    if File.directory? "/opt/consul/etc/"
      true
    else
      false
    end
  end
end
