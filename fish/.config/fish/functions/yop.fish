function yop --wraps='doas openvpn --config /home/joshua/mullvad_config_linux_sg_sin/mullvad_sg_sin.conf' --description 'doas openvpn --config /home/joshua/mullvad_config_linux_sg_sin/mullvad_sg_sin.conf'
  doas openvpn --config /home/joshua/mullvad_config_linux_sg_sin/mullvad_sg_sin.conf $argv
        
end
