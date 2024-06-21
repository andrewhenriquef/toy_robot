export function rotateRobot(direction) {
  const robot = document.getElementById('robot');
  robot.className = 'robot ' + direction;
}