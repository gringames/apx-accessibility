extends Node

enum Type {Hold, Toggle, None}

const TYPE_TO_STRING: Dictionary[Type, String] = {
	Type.Hold: "Hold",
	Type.Toggle: "Toggle",
	Type.None: "None",
}
