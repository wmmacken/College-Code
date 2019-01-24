; AUTHOR: Wayne MacKenzie
; Satellite Remote Sensing I Final Project
; Date: 12/05/2005
; Written in IDL
; This program calculates the distortion (Earth curvature and panchromatic) of the
; pixel and places it in a binary file name ‘distortion.dat’. This also makes an across
; track distortion plot showing size of pixels.

;open file
viewing=fltarr(640,512)
lat=fltarr(640,512)
lon-fltarr(640,512)
dir=‘/c2/data/ats670/students/mackenzie/final_project/data/‘
openr,1,dir+’viewing_angle.dat’
readu,1,viewing
close,1

openr,2,dir+'lat.dat'
readu,2,lat
close,2

openr,3,dir+'lon.dat'
readu,3,lon
close,3

;constant definition
lonrad=lon*!dtor
viewrad=viewing*!dtor
re=6.37e3
IFOV=0.081271*!dtor
h=705.

;across track distortion calculation
across=fltarr(640,512)
across=IFOV*(h)*(1/cos(viewrad))^2

;along track distortion calculation
along=fltarr(640,512)
along=IFOV*h*(1/cos(viewrad))

;final total error
pixel=fltarr(640,512)
pixel=(along*across)

;plot distortion
set_plot,'ps'
device,filename='across_track.ps'
plot,pixel[*,0],title='Across Track Distortion',ytitle='Area of Pixel (km^2)',xtitle='Pixel Location'
device,/close
set_plot,'X'

;make final distortion output file
openw,4,dir+'distortion.dat'
writeu,4,pixel
close,4

end