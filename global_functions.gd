extends Node

func easeInOutQuint(x: float) -> float:
	return -(cos(PI * x) - 1) / 2
