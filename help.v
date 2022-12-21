
// print help
pub fn print_help() {
    println("SYNTAX: vodo [CMD] [VALUE]")
	
	// commands
	println("Commands:")
	println("\tinit ... init vodo")
	println("\thelp ... print this help")
	println("\treset ... reset vodo")
	println("\tadd ... add new task")
	println("\tdel ... delete task")
	println("\tlist ... list all tasks")

	// examples/command usage
	println("Usage:")
	println("\tinit ... 'vodo init'")
	println("\thelp ... 'vodo help'")
	println("\treset ... 'vodo reset'")
	println("\tadd ... 'vodo add \"some-task\"'")
	println("\tdel ... TODO") // TODO
	println("\tlist ... 'vodo list'")
}