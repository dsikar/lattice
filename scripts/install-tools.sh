#!/usr/bin

# As described in http://www.clifford.at/icestorm/

sudo apt-get update

sudo apt-get install build-essential clang bison flex libreadline-dev \
                     gawk tcl-dev libffi-dev git mercurial graphviz   \
                     xdot pkg-config python python3 libftdi-dev -y

# Clone repositories

cd ..

git clone https://github.com/cliffordwolf/icestorm.git icestorm
cd icestorm
make -j$(nproc)
sudo make install

cd ..

git clone https://github.com/cseed/arachne-pnr.git arachne-pnr
cd arachne-pnr
make -j$(nproc)
sudo make install

cd ..

git clone https://github.com/cliffordwolf/yosys.git yosys
cd yosys
make -j$(nproc)
sudo make install

cd ..

# Add rules

echo "ACTION==\"add\", ATTR{idVendor}==\"0403\", ATTR{idProduct}==\"6010\", MODE:=\"666\"" > 53-lattice-ftdi.rules
 
sudo mv 53-lattice-ftdi.rules /etc/udev/rules.d/

# Move ice40.mk

sudo cp scripts/ice40.mk /usr/local/include

# Additional tips from https://discourse.southlondonmakerspace.org/t/electronics-gate-array-workshop-notes-lattice-ice40/4861

# Recommendations:

# The program to put a bin file onto the Icestick hardware usually needs root permission, so good to give it that with setuid bit:

sudo chmod u+s `which iceprog` 

# Plug in USB stick at this point

# make 
# NB If this error is thrown:
# makefile:4: *** missing separator (did you mean TAB instead of 8 spaces?). Stop.
# Substitute spaces for a tab in makefile line
#         @echo done

cd example 

make 

# Run on hardware

iceprog tiny.bin

