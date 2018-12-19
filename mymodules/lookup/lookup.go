package lookup

import (
	"github.com/yuin/gopher-lua"
)

func Preload(L *lua.LState) {
	L.PreloadModule("lookup", Loader)
}

func Loader(L *lua.LState) int {
	// register functions to the table
	mod := L.SetFuncs(L.NewTable(), exports)
	// register other stuff
	// L.SetField(mod, "name", lua.LString("value"))

	// returns the module
	L.Push(mod)
	return 1
}

var exports = map[string]lua.LGFunction{
	"getDirectBoss":    GetDirectBoss,
	"getAllBoss":       GetAllBoss,
	"getDirectTagBoss": GetDirectTagBoss,
}

func GetDirectBoss(L *lua.LState) int {
	str := L.CheckString(1)
	println("为 " + str + " 找到他(她)的直接BOSS")
	// if err != nil {
	// 	L.Push(lua.LNil)
	// 	L.Push(lua.LString(err.Error()))
	// 	return 2
	// }
	return 0
}

func GetAllBoss(L *lua.LState) int {
	str := L.CheckString(1)
	println("为 " + str + " 找到他(她)的所有BOSS")
	// if err != nil {
	// 	L.Push(lua.LNil)
	// 	L.Push(lua.LString(err.Error()))
	// 	return 2
	// }
	return 0
}

func GetDirectTagBoss(L *lua.LState) int {
	str := L.CheckString(1)
	tag := L.CheckString(2)
	println("为 " + str + " 找到他(她)的 " + tag + " ")
	// if err != nil {
	// 	L.Push(lua.LNil)
	// 	L.Push(lua.LString(err.Error()))
	// 	return 2
	// }
	return 0
}
