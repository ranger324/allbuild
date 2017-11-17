import os;
import sys;
import time;

os.system("clear");
x=1;
while x<20:
  sys.stdout.write("\033[5;"+str(x)+"H=>");
  sys.stdout.flush();
  time.sleep(1);
  x=x+1;
