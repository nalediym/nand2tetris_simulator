#!/bin/bash

# Create a directory for nand2tetris if it doesn't exist 

# Change to the nand2tetris directory
cd ~/Documents/Projects/nand2tetris

# Create Dockerfile
cat << EOF > Dockerfile
FROM openjdk:8

WORKDIR /nand2tetris

COPY . .

CMD ["/bin/bash"]
EOF

# Create a script to run simulators
cat << EOF > run_simulator.sh
#!/bin/bash

case \$1 in
  hardware)
    ./HardwareSimulator.sh
    ;;
  cpu)
    ./CPUEmulator.sh
    ;;
  vm)
    ./VMEmulator.sh
    ;;
  *)
    echo "Usage: ./run_simulator.sh [hardware|cpu|vm]"
    exit 1
    ;;
esac
EOF

chmod +x run_simulator.sh

# Build Docker image
docker build -t nand2tetris .

# Print instructions
echo "Nand2tetris Docker environment is ready!"
echo "To run a simulator, use the following command:"
echo "docker run -it --rm -v \$(pwd):/nand2tetris nand2tetris ./run_simulator.sh [hardware|cpu|vm]"