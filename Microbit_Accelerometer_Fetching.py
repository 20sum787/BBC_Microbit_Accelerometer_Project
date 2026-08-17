from microbit import *

while True:
    a_x = accelerometer.get_x()
    a_y = accelerometer.get_y()
    a_z = accelerometer.get_z()
    print(str(a_x) + "," + str(a_y) + "," + str(a_z))
    sleep(20)

# This MicroPython code fetches accelerometer data from the Microbit through a serial port.
# The sampling time interval is set here to 20ms, for a sample rate of 50Hz - this can be adjusted.
