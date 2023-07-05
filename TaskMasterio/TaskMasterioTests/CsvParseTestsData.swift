//
//  CsvParseTestsData.swift
//  TaskMasterioTests
//
//  Created by Aynur Nasybullin on 05.07.2023.
//

struct CsvParseTestsData {
    private static let id = TestsData.id
    private static let id2 = TestsData.id2
    
    static let idInvalid = ["id;text;priority;deadline;isDone;createdOn;updatedOn;\n",
                            "1;\"id is Int()\";low;168655000;false;168655000;168655000;\n",
                            "false;\"id is boolean\";low;168655000;false;168655000;168655000;\n",
                            "Date()\"id is Date()\";low;168655000;false;168655000;168655000;\n",
                            "1.5\"id is Double()\";low;168655000;false;168655000;168655000;\n",
                            "[String: Any]();\"id is [String: Any]()\";low;168655000;false;168655000;168655000;\n",
                            "\"\";\"id is empty string\";low;168655000;false;168655000;168655000;\n",
                            "\"sajdnaksfnklnckzjnvkzjnd\";\"id is short string\";low;168655000;false;168655000;168655000;\n",
                            "\"sajdnaksfnklncsdjnskjnksncljasnvckjskzjnv\";\"id is long string\";low;68655000;false;168655000;168655000;\n",
                            ";\"id undefined\";low;168655000;false;168655000;168655000;"]
    
    static let idValid = ["id;text;priority;deadline;isDone;createdOn;updatedOn;\n",
                          "\"\(id)\";\"id valid\";low;168655000;false;168655000;168655000;\n",
                          "\"\(id2)\";\"id valid 2\";low;168655000;false;168655000;168655000;"]
    
    static let textInvalid = ["id;text;priority;deadline;isDone;createdOn;updatedOn;\n",
                              "\"\(id)\";1;low;168655000;false;68655000;168655000;\n",
                              "\"\(id)\";false;low;168655000;false;168655000;168655000;\n",
                              "\"\(id)\";Date();low;168655000;false;168655000;168655000;\n",
                              "\"\(id)\";1.5;low;168655000;false;168655000;168655000;\n",
                              "\"\(id)\";[String: Any]();low;168655000;false;168655000;168655000;\n",
                              "\"\(id)\";;low;168655000;false;168655000;168655000;"]
    
    static let textValid = ["id;text;priority;deadline;isDone;createdOn;updatedOn;\n",
                            "\"\(id)\";\"text valid 1\";low;168655000;false;168655000;168655000;\n",
                            "\"\(id)\";\"   \";low;168655000;false;168655000;168655000;\n",
                            "\"\(id)\";\"\";low;168655000;false;168655000;168655000;"]
    
    static let priorityInvalid = ["id;text;priority;deadline;isDone;createdOn;updatedOn;\n",
                                  "\"\(id)\";\"priority invalid 1\";8;168655000;false;168655000;168655000;\n",
                                  "\"\(id)\";\"priority invalid 2\";hard;168655000;false;168655000;168655000;\n",
                                  "\"\(id)\";\"priority invalid 3\";\"   \";168655000;false;168655000;168655000;\n",
                                  "\"\(id)\";\"priority invalid 4\";\"\";168655000;false;168655000;168655000;\n",
                                  "\"\(id)\";\"priority invalid 5\";false;168655000;false;168655000;168655000;\n",
                                  "\"\(id)\";\"priority invalid 6\";Date();168655000;false;168655000;168655000;\n",
                                  "\"\(id)\";\"priority invalid 7\";1.5;168655000;false;168655000;168655000;\n",
                                  "\"\(id)\";\"priority invalid 8\";[String: Any]();168655000;false;168655000;168655000;"]
    
    static let priorityValid = ["id;text;priority;deadline;isDone;createdOn;updatedOn;\n",
                                "\"\(id)\";\"priority valid 1\";medium;168655000;false;168655000;168655000;\n",
                                "\"\(id)\";\"priority valid 2\";low;168655000;false;168655000;168655000;\n",
                                "\"\(id)\";\"priority valid 3\";high;168655000;false;168655000;168655000;\n",
                                "\"\(id)\";\"priority valid 4\";;168655000;false;168655000;168655000;"]
    
    static let deadlineInvalid = ["id;text;priority;deadline;isDone;createdOn;updatedOn;\n",
                                  "\"\(id)\";\"deadline invalid 1\";low;\"168655000\";false;168655000;168655000;\n",
                                  "\"\(id)\";\"deadline invalid 2\";high;   ;false;168655000;168655000;\n",
                                  "\"\(id)\";\"deadline invalid 3\";high;  ;false;168655000;168655000;\n",
                                  "\"\(id)\";\"deadline invalid 4\";low;false;false;168655000;168655000;\n",
                                  "\"\(id)\";\"deadline invalid 5\";high;Date();false;168655000;168655000;\n",
                                  "\"\(id)\";\"deadline invalid 6\";low;[String: Any]();false;168655000;168655000;\n",
                                  "\"\(id)\";\"deadline invalid 7\";high;168655000.55;false;168655000;168655000;"]
    
    static let deadlineValid = ["id;text;priority;deadline;isDone;createdOn;updatedOn;\n",
                                "\"\(id)\";\"deadline valid 1\";low;168655000;false;168655000;168655000;\n",
                                "\"\(id)\";\"deadline valid 2\";low;;false;168655000;168655000;"]
    
    static let isDoneInvalid = ["id;text;priority;deadline;isDone;createdOn;updatedOn;\n",
                                "\"\(id)\";\"isDone invalid 1\";low;168655000;\"false\";168655000;168655000;\n",
                                "\"\(id)\";\"isDone invalid 2\";low;168655000;  ;168655000;168655000;\n",
                                "\"\(id)\";\"isDone invalid 3\";low;168655000; ;168655000;168655000;\n",
                                "\"\(id)\";\"isDone invalid 4\";low;168655000;1;168655000;168655000;\n",
                                "\"\(id)\";\"isDone invalid 5\";low;168655000;1.5;168655000;168655000;\n",
                                "\"\(id)\";\"isDone invalid 6\";low;168655000;Date();168655000;168655000;\n",
                                "\"\(id)\";\"isDone invalid 7\";low;168655000;[String: Any]();168655000;168655000;\n",
                                "\"\(id)\";\"isDone invalid 8\";low;168655000,;168655000;168655000;"]
    
    static let isDoneValid = ["id;text;priority;deadline;isDone;createdOn;updatedOn;\n",
                              "\"\(id)\";\"isDone valid 1\";low;168655000;false;168655000;168655000;\n",
                              "\"\(id)\";\"isDone valid 2\";low;168655000;true;168655000;168655000;"]
    
    static let createdOnInvalid = ["id;text;priority;deadline;isDone;createdOn;updatedOn;\n",
                                   "\"\(id)\";\"createdOn invalid 1\";low;168655000;false;\"168655000\";168655000;\n",
                                   "\"\(id)\";\"createdOn invalid 2\";low;168655000;true;   ;168655000;\n",
                                   "\"\(id)\";\"createdOn invalid 3\";low;168655000;true;  ;168655000;\n",
                                   "\"\(id)\";\"createdOn invalid 4\";low;168655000;true;Date();168655000;\n",
                                   "\"\(id)\";\"createdOn invalid 5\";low;168655000;true;alse;68655000;\n",
                                   "\"\(id)\";\"createdOn invalid 6\";low;168655000;true;[String: Any]();168655000;\n",
                                   "\"\(id)\";\"createdOn invalid 7\";low;168655000;true;168655000.55;168655000;\n",
                                   "\"\(id)\";\"createdOn invalid 8\";low;168655000;true;;168655000;"]
    
    static let createdOnValid = ["id;text;priority;deadline;isDone;createdOn;updatedOn;\n",
                                 "\"\(id)\";\"createdOn valid 1\";low;168655000;false;168655000;168655000;"]
    
    static let updatedOnInvalid = ["id;text;priority;deadline;isDone;createdOn;updatedOn;\n",
                                   "\"\(id)\";\"updatedOn invalid 1\";low;168655000;false;68655000;\"168655000\";\n",
                                   "\"\(id)\";\"updatedOn invalid 2\";low;168655000;true;168655000;    ;\n",
                                   "\"\(id)\";\"updatedOn invalid 3\";low;168655000;true;168655000;  ;\n",
                                   "\"\(id)\";\"updatedOn invalid 4\";low;168655000;true;168655000;Date();\n",
                                   "\"\(id)\";\"updatedOn invalid 5\";low;168655000;true;168655000;false;\n",
                                   "\"\(id)\";\"updatedOn invalid 6\";low;168655000;true;168655000;[String: Any]();\n",
                                   "\"\(id)\";\"updatedOn invalid 7\";low;168655000;false;168655000;168655000.55;"]
    
    static let updatedOnValid = ["id;text;priority;deadline;isDone;createdOn;updatedOn;\n",
                                 "\"\(id)\";\"updatedOn valid 1\";low;168655000;false;168655000;168655000;\n",
                                 "\"\(id)\";\"updatedOn valid 2\";low;168655000;true;168655000;168655000;\n",
                                 "\"\(id)\";\"updatedOn valid 3\";low;168655000;true;168655000;"]
}
