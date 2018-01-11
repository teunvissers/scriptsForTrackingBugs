import matplotlib.pyplot as plt
import numpy
from numpy.random import normal, uniform
from scipy.optimize import *
import os.path
from scipy.ndimage.filters import gaussian_filter1d
import matplotlib.gridspec as gridspec
from toolsForBugs import *

# some functions to build further on

def readPositions():
	BIGLIST, PROPERTIES = readCoordinateFile(filename, correctionslope=correctionslope, cut1=cut1, cut2=cut2)
	numberOfFrames = len(BIGLIST) # the number of frames in the dataset

def readTrajectories():
	trajectories, numberOfFrames = readTrackingFile(filename, 30)


