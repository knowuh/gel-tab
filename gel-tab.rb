#!/usr/bin/env ruby

#
# Make a time-machine backup location on a network drive
# Creates an appropriate disk image, that must to be copied onto the remote drive.
# Recipe taken from: 
#   http://www.alexpadron.com/2009/03/12/time-machine-backup-to-a-network-share/
# 

# write system-prefs
default_results = %x{defaults write com.apple.systempreferences TMShowUnsupportedNetworkVolumes 1}

# destination dir:
destintation_dir = "#{ENV['HOME']}/Desktop"

# Create volume name, this is the Volume name of the Image.
# must follow very specific pattern (see url above)

comp_name = %x{hostname}.chop
mac_address =%x{ifconfig en0 | grep ether}.chop
mac_address =mac_address.gsub /\s+ether\s+([0-9A-Fa-f])/, '\1'
mac_address =mac_address.gsub /:/, ''
volume_name = "#{comp_name}_#{mac_address}".gsub /\s+/, ''



# Where we write the disk image (must be copied later!)
filename = "#{destintation_dir}/#{volume_name}.sparsebundle"
puts filename

# find out how large the sparse image should be:
block_size = %x{df / | grep /dev/ | tr -s ' ' | cut -d " " -f2}.chop

# make the image:
command = "hdiutil create -type SPARSEBUNDLE -size #{block_size}b -fs HFS+j -volname #{volume_name} #{filename}"

# print the results
puts %x{#{command}}