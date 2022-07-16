#####################################################################
# This file is part of Erin-1.                                      #
#                                                                   #
# Erin-1 is free software: you can redistribute it and/or modify it #
# under the terms of the GNU Affero General Public License as       #
# published by the Free Software Foundation, either version 3 of    #
# the License, or (at your option) any later version.               #
#                                                                   #
# Erin-1 is distributed in the hope that it will be useful,         #
# but WITHOUT ANY WARRANTY; without even the implied warranty of    #
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.              #
# See the GNU Affero General Public License for more details.       #
#                                                                   #
# You should have received a copy of the GNU Affero General Public  #
# License along with Erin-1.                                        #
# If not, see <https://www.gnu.org/licenses/>.                      #
#####################################################################


extends KinematicBody

var S=10 #Speed
var Mo=0.05 #mouse sensitivity
var D=Vector3() #direction
var H=6 #horizontal_acceleration
var H_V=Vector3() #horizontal_Velocity
var M=Vector3() #Movenment
var G=20 #gravity
var J=10 #jump
var G_V=Vector3() #Gravity_velocity
var onF=false #full_contract
var AA=1 #Air_acceleration
var NA=6 #Normal_acceleration

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg2rad(-event.relative.x*Mo))
		get_node("Head").rotate_x(deg2rad(-event.relative.y*Mo))
		get_node("Head").rotation.x=clamp(get_node("Head").rotation.x,deg2rad(-89),deg2rad(89))

func _physics_process(delta):
	D=Vector3()
	if $GroundCheck.is_colliding():onF=true
	else:onF=false
	if not is_on_floor():
		G_V+=Vector3.DOWN*G*delta
		H=AA
	elif is_on_floor() and onF:
		G_V=-get_floor_normal()*G
		H=NA
	else:
		get_floor_normal()
		H=NA
	if Input.is_action_just_pressed(' ') and (is_on_floor() or $GroundCheck.is_colliding()):G_V=Vector3.UP*J
	if Input.is_action_pressed('w'):D-=transform.basis.z
	if Input.is_action_pressed('s'):D+=transform.basis.z
	if Input.is_action_pressed('a'):D-=transform.basis.x
	if Input.is_action_pressed('d'):D+=transform.basis.x
	D=D.normalized() #prevent move faster diagonally
	H_V=H_V.linear_interpolate(D*S,H*delta)
	M.z=H_V.z+G_V.z
	M.x=H_V.x+G_V.x
	M.y=G_V.y
	move_and_slide(M,Vector3.UP)
