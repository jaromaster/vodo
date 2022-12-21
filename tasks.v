import os
import rand

// Task struct
struct Task {
	id string [required]
	description string [required]
}

// convert task to csv row (for persisting)
fn (t Task) to_csv() string {

	s := "${t.id},${t.description}"
	return s
}


// add new task to tasks
fn add_task(vodo_csv_path string, task_desc string) ? {

	if os.is_file(vodo_csv_path) == false {
		return error("could not find vodo folder / file. please run 'vodo init' first")
	}

	mut csv_file := os.open_append(vodo_csv_path) or {
		return error("could not add task to vodo file. please run 'vodo init' first")
	}
	defer {csv_file.close()}

	task := Task{id: rand.uuid_v4(), description: task_desc}

	csv_file.writeln(task.to_csv()) or {
		return error("could not write to vodo file. please run 'vodo init' first")
	}
}


// get all tasks as lists of strings (each row of csv file separated by comma)
fn get_tasks(vodo_csv_path string) ?[][]string {
	separator := ","

	lines := os.read_lines(vodo_csv_path) or {
		return error("could not read vodo file. please run 'vodo init' first")
	}
	
	mut tasks := [][]string{}
	for i in 1..lines.len { // skip header => 1..end
		task := lines[i].split(separator)
		tasks << task
	}

	return tasks
}


// print the tasks as a list
fn print_tasks(tasks [][]string) {
	list_style := "-" // style of list items

	for task in tasks {
		description := task[1]
		output := "${list_style} ${description}"

		println(output)
	}
}


// TODO delete task

// TODO search/filter tasks