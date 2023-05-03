use itertools::Itertools;
use std::{
    env::args,
    process::{exit, Command},
};

trait InputWrapper {
    fn get_commits(&self) -> String;
    fn get_inputs(&self) -> Vec<String>;
}

struct RealInputs {}

impl InputWrapper for RealInputs {
    fn get_commits(&self) -> String {
        let Ok(output) = Command::new("git").args(["local-main-branch"]).output() else {
        exit(1)
    };

        let commit_range = format!("{}..HEAD", String::from_utf8_lossy(&output.stdout).trim());

        let Ok(output) = Command::new("git").args(["--no-pager", "log", "--reverse", "--format=%b", &commit_range]).output() else {
        exit(1)
    };

        return String::from_utf8_lossy(&output.stdout).trim().to_string();
    }

    fn get_inputs(&self) -> Vec<String> {
        return args().into_iter().filter(|a| !a.contains("-")).collect();
    }
}

fn extract_section(input_wrapper: &dyn InputWrapper) -> String {
    let result = input_wrapper.get_commits();

    return result
        .split("\n")
        .skip(2)
        .map(|s| s.trim())
        .intersperse("\n")
        .collect();
}

fn main() {
    let result = extract_section(&RealInputs {});

    if args().into_iter().any(|a| a == "-p") {
        println!("{:?}", result);
    }
}

#[cfg(test)]
mod test {
    use super::*;
    struct FakeInputs {
        commits: String,
        inputs: Vec<String>,
    }

    impl InputWrapper for FakeInputs {
        fn get_inputs(&self) -> Vec<String> {
            return self.inputs.clone();
        }

        fn get_commits(&self) -> String {
            return self.commits.clone();
        }
    }

    #[test]
    fn returns_whole_body_if_there_are_no_inputs() {
        let inputs = Vec::new();
        let commits = "feat: This is a commit without headings

        It was created to ensure that without inputs,
        extract_section returns the whole body of the commit"
            .to_string();

        assert_eq!(
            extract_section(&FakeInputs {
                inputs: inputs,
                commits: commits
            }),
            "
It was created to ensure that without inputs,
extract_section returns the whole body of the commit
        "
            .trim()
        );
    }
}
