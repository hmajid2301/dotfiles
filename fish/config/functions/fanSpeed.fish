function fanSpeed
  echo "Setting fan speed to $argv[1]"
  for x in (seq 6)
    OpenCorsairLink.elf --device 0 --fan channel=$x,mode=1,rpm=$argv[1]
  end
end
