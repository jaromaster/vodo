import os
import strconv
import time

// Task struct
struct Task {
	id int [required]
	description string [required]
	until string [required]
}

// convert task to csv row (for persisting)
fn (t Task) to_csv() string {

	s := "${t.id},${t.description},${t.until}"
	return s
}


// add new task to tasks
fn add_task(vodo_csv_path string, task_desc string, time_str string) ? {
	old_tasks := get_tasks(vodo_csv_path) or {
		return err
	}

	mut csv_file := os.open_append(vodo_csv_path) or {
		return error("could not add task to vodo file. please run 'vodo init' first")
	}
	defer {csv_file.close()}

	// get next id
	mut max_id := 0
	for t in old_tasks {
		max_id = t.id
	}

	until_time := time_str
	if time_str != until_replacement { // check time format if not empty
		time.parse(time_str) or {
			err_msg := "invalid datetime format.\nexamples:\nvodo add \"some-task\" '1980-07-11 21:00:00' or\nvodo add \"some-task\" '-' (to ignore datetime)"
			return error(err_msg)
		}
	}

	task := Task{id: max_id+1, description: task_desc, until: until_time}

	csv_file.writeln(task.to_csv()) or {
		return error("could not write to vodo file. please run 'vodo init' first")
	}
}


// get all tasks as lists of strings (each row of csv file separated by comma)
fn get_tasks(vodo_csv_path string) ?[]Task {
	

	lines := os.read_lines(vodo_csv_path) or {
		return error("could not read vodo file. please run 'vodo init' first")
	}
	
	mut tasks := []Task{}
	for i in 1..lines.len { // skip header => 1..end
		task_arr := lines[i].split(csv_separator)
		id := strconv.atoi(task_arr[0]) or {
			return err
		}
		description := task_arr[1]
		until := task_arr[2]
		task := Task{id: id, description: description, until: until}

		tasks << task
	}

	return tasks
}


// print the tasks as a list
fn print_tasks(tasks []Task) {

	for task in tasks {
		output := "${list_style}${task.id}\t${task.description}" // display task without time
		output_with_time := "${list_style}${task.id}\t${task.description}, ${task.until}" // display with time

		if task.until == until_replacement {
			println(output)
			continue
		}
		println(output_with_time)
	}
}


// delete task by id
fn delete_task(task_id int, vodo_csv_path string) ?{
	
	mut old_tasks := get_tasks(vodo_csv_path) or {
		return err
	}

	mut csv_file := os.open_file(vodo_csv_path, "w") or {
		return err
	}
	defer {csv_file.close()}

	// writer header to file
	csv_file.writeln(csv_header) or {
		return err
	}

	// write all tasks to file, but delete the task with id by skipping it
	for t in old_tasks {
		if t.id == task_id {
			continue
		}
		csv_file.writeln(t.to_csv()) or {
			return err
		}
	}
}


// search/filter tasks and return matches
fn search_tasks(search string, vodo_csv_path string) ?[]Task {
	mut old_tasks := get_tasks(vodo_csv_path) or {
		return err
	}

	search_lower := search.to_lower()

	mut potential_targets := []Task{cap: old_tasks.len}
	for t in old_tasks {
		if t.description.to_lower().contains(search_lower) {
			potential_targets << t
		}
	}

	return potential_targets
}