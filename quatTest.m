clear all; close all; clc

yaw = pi/6;
pitch = pi/2;
roll = 0;

cy = cos(yaw * 0.5);
sy = sin(yaw * 0.5);
cp = cos(pitch * 0.5);
sp = sin(pitch * 0.5);
cr = cos(roll * 0.5);
sr = sin(roll * 0.5);

q = quaternion([yaw, pitch, roll],'euler','XYZ','frame')
q1 = quaternion(0.7,0.15,0.65,0).normalize()