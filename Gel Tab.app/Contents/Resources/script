#!/usr/bin/env ruby
default_results = %x{defaults write com.apple.systempreferences TMShowUnsupportedNetworkVolumes 1}
comp_name = %x{hostname}.chop
mac_address =%x{ifconfig en0 | grep ether}.chop
mac_address =mac_address.gsub /\s+ether\s+([0-9A-Fa-f])/, '\1'
mac_address =mac_address.gsub /:/, ''
name = "#{comp_name}_#{mac_address}".gsub /\s+/, ''
puts name
home = ENV['HOME']
desk = "#{home}/Desktop"
filename = "#{desk}/#{name}.sparsebundle"
block_size = %x{df / | grep /dev/ | tr -s ' ' | cut -d " " -f2}.chop
puts block_size
command = "hdiutil create -type SPARSEBUNDLE -size #{block_size}b -fs HFS+j -volname #{name} #{filename}"
puts command
esults = %x{#{command}}
puts results
