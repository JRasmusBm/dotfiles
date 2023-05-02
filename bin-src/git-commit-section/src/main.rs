use std::{
    env::args,
    process::{exit, Command},
};

fn get_inputs() -> String {
    let Ok(output) = Command::new("git").args(["local-main-branch"]).output() else {
        exit(1)
    };

    let commit_range = format!("{}..HEAD", String::from_utf8_lossy(&output.stdout).trim());

    let Ok(output) = Command::new("git").args(["--no-pager", "log", "--reverse", "--format=%b", &commit_range]).output() else {
        exit(1)
    };

    return String::from_utf8_lossy(&output.stdout).trim().to_string();
}

fn main() {
    let result = get_inputs();

    let Some(header_from) = args().into_iter().filter(|a| a != "-p" && a != "-r").nth(1);
    let header_to = args().into_iter().filter(|a| a != "-p" && a != "-r").nth(2);

    let result = result.split(header_from.chars()).reduce(|acc, cur| {
        acc.to_owned().push_str(&cur);
        return acc;
    });

    if args().into_iter().any(|a| a == "-p") {
        println!("{:?}", result);
    }
}
