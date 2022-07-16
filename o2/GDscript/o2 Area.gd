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


extends MeshInstance

var O=false
var Blur=2

func _ready():
	$'../../Player'.translation=Vector3(rand_range(-1024,1024),3,rand_range(-1024,1024))

func _physics_process(delta):
	if scale>=Vector3.ZERO:scale-=Vector3(.1422,.1422,.1422)
	if O==true:
		Blur+=1
		$Vignetting.material.set_shader_param("Blur",Blur)
		if Blur>=750:
			scale=Vector3(1536,1536,1536)
			$'../../Player'.translation=Vector3(rand_range(-1024,1024),3,rand_range(-1024,1024))
			Blur=2
			$Vignetting.material.set_shader_param("Blur",Blur)
	if O==false and Blur>=5:
		Blur-=3
		$Vignetting.material.set_shader_param("Blur",Blur)

func _on_Area_body_exited(body):if body.is_in_group("Player"):O=true
func _on_Area_body_entered(body):if body.is_in_group("Player"):O=false
