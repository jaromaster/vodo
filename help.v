
// print help
pub fn print_help() {
	// basic syntax
    println("Syntax:")
	println("\tvodo [CMD] [VALUE]")
	
	// commands
	println("Commands:")
	println("\tinit ... init and setup vodo")
	println("\thelp ... print this help")
	println("\treset ... reset vodo (remove all data)")
	println("\tadd ... add new task")
	println("\tdel ... delete task with id")
	println("\tsearch ... search for specific task")
	println("\tlist ... list all tasks")

	// examples/command usage
	println("Usage:")
	println("\tinit ... 'vodo init'")
	println("\thelp ... 'vodo help'")
	println("\treset ... 'vodo reset'")
	println("\tadd ... 'vodo add \"some-task\"'") // TODO time support and format: "YYYY-MM-DD HH:mm:ss"
	println("\tdel ... 'vodo del ID'")
	println("\tsearch ... 'vodo search \"some-task\"'")
	println("\tlist ... 'vodo list'")
}