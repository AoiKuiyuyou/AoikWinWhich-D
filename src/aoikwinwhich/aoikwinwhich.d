//
module aoikwinwhich;

import std.algorithm: any;
import std.algorithm: endsWith;
import std.algorithm: map;
import std.algorithm: filter;
import std.array : appender;
import std.array : array;
import std.array : join;
import std.array : split;
import std.file : FileException;
import std.file : isFile;
import std.path : buildPath;
import std.path : pathSeparator;
import std.process: env = environment;
import std.stdio : writeln;
import std.string : toLower;

//
bool contain(string[] item_s, string item) {
    foreach (_item; item_s) {
        if (_item == item) {
            return true;
        }
    }
    return false;
}

string[] uniq(string[] item_s) {
    auto item_s_new = appender!(string[]);

    foreach (item; item_s) {
        if (!contain(item_s_new.data, item)) {
            item_s_new.put(item);
        }
    }

    return item_s_new.data;
}

bool file_exists(string path) {
    auto path_is_file = false;

    try {
        path_is_file = path.isFile();
    } catch (FileException) {}

    return path_is_file;
}

string[] find_executable(string prog) {
    // 8f1kRCu
    auto env_var_PATHEXT = env.get(`PATHEXT`);
    /// can be ""

    // 6qhHTHF
    // split into a list of extensions
    auto ext_s = (env_var_PATHEXT == "")
        ? []
        : env_var_PATHEXT.split(pathSeparator);

    // 2pGJrMW
    // strip
    ext_s = array(ext_s.map!(x => x));

    // 2gqeHHl
    // remove empty
    ext_s = array(ext_s.filter!(x => x != ""));

    // 2zdGM8W
    // convert to lowercase
    ext_s = array(ext_s.map!(x => x.toLower()));

    // 2fT8aRB
    // uniquify
    ext_s = uniq(ext_s);

    // 4ysaQVN
    auto env_var_PATH = env.get(`PATH`);
    /// can be ""

    // 6mPI0lg
    auto dir_path_s = (env_var_PATH == "")
        ? []
        : env_var_PATH.split(pathSeparator);

    // 5rT49zI
    // insert empty dir path to the beginning
    //
    // Empty dir handles the case that |prog| is a path, either relative or
    //  absolute. See code 7rO7NIN.
    dir_path_s = [""] ~ dir_path_s;

    // 2klTv20
    // uniquify
    dir_path_s = uniq(dir_path_s);

    //
    auto prog_lower = prog.toLower();

    auto prog_has_ext = ext_s.any!(x => prog_lower.endsWith(x));

    // 6bFwhbv
    auto exe_path_s = appender!(string[]);

    foreach (dir_path; dir_path_s) {
        // 7rO7NIN
        // synthesize a path with the dir and prog
        auto path = (dir_path == "")
            ? prog
            : buildPath(dir_path, prog);

        // 6kZa5cq
        // assume the path has extension, check if it is an executable
        if (prog_has_ext && file_exists(path)) {
            exe_path_s.put(path);
        }

        // 2sJhhEV
        // assume the path has no extension
        foreach (ext; ext_s) {
            // 6k9X6GP
            // synthesize a new path with the path and the executable extension
            auto path_plus_ext = path ~ ext;

            // 6kabzQg
            // check if it is an executable
            if (file_exists(path_plus_ext)) {
                exe_path_s.put(path_plus_ext);
            }
        }
    }

    // 8swW6Av
    // uniquify
    auto exe_path_s_uniq = uniq(exe_path_s.data);

    //
    return exe_path_s_uniq;
}

void main(string[] args)
{
    // 9mlJlKg
    // check if one cmd arg is given
    if (args.length != 2) {
        // 7rOUXFo
        // print program usage
        writeln(`Usage: aoikwinwhich PROG`);
        writeln(``);
        writeln(`#/ PROG can be either name or path`);
        writeln(`aoikwinwhich notepad.exe`);
        writeln(`aoikwinwhich C:\Windows\notepad.exe`);
        writeln(``);
        writeln(`#/ PROG can be either absolute or relative`);
        writeln(`aoikwinwhich C:\Windows\notepad.exe`);
        writeln(`aoikwinwhich Windows\notepad.exe`);
        writeln(``);
        writeln(`#/ PROG can be either with or without extension`);
        writeln(`aoikwinwhich notepad.exe`);
        writeln(`aoikwinwhich notepad`);
        writeln(`aoikwinwhich C:\Windows\notepad.exe`);
        writeln(`aoikwinwhich C:\Windows\notepad`);

        // 3nqHnP7
        return;
    }

    // 9m5B08H
    // get name or path of a program from cmd arg
    auto prog = args[1];


    // 8ulvPXM
    // find executables
    auto path_s = find_executable(prog);

    // 5fWrcaF
    // has found none, exit
    if (path_s.length == 0) {
        // 3uswpx0
        return;
    }

    // 9xPCWuS
    // has found some, output
    auto txt = array(path_s).join("\n");

    writeln(txt);

    // 4s1yY1b
    return;
}
