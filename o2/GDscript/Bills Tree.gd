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


extends Spatial

func _ready():
	randomize()
	translation=Vector3(rand_range(-1024,1024),0,rand_range(-1024,1024))
