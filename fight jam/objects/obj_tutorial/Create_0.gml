index = 0;

paths = [
	"tutorials\\tut0.mp4"
]

depth = DEPTH.tutorial;

function play()
{
	video_open(paths[index]);
	video_enable_loop(true);
}

function stop()
{
	video_close();
	instance_destroy();
}

play();