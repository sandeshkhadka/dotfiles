#!/bin/python3
import os
import getpass
import shutil
import sys

username = getpass.getuser()

if "doc" in sys.argv:
    base_path = f"/home/{username}/Documents/"
else:
    base_path = f"/home/{username}/Downloads/"

file_list = [
    f for f in os.listdir(base_path) if os.path.isfile(os.path.join(base_path, f))
]

file_paths = {
    "compressed": base_path + "compressed/",
    "images": base_path + "images/",
    "videos": base_path + "videos/",
    "text": base_path + "text/",
    "packages": base_path + "packages/",
    "pdfs": base_path + "pdfs/",
    "documents": base_path + "documents/",
    "epubs": base_path + "epubs/",
    "music": base_path + "music/",
}


file_extensions = {
    "compressed": [".zip", ".rar", ".7z", ".gz"],
    "images": [".jpg", ".jpeg", ".png", ".gif", ".bmp"],
    "videos": [".mp4", ".avi", ".mkv", ".mov", ".wmv"],
    "text": [".txt", ".md"],
    "documents": [".doc", ".docx", ".rtf", ".odt", ".csv", ".xlsx"],
    "pdfs": [".pdf"],
    "packages": [".deb"],
    "epubs": [".epub"],
    "music": [".mp3", ".wav"],
}

for path in file_paths.values():
    if not os.path.exists(path):
        print(f"{path} does not exists.")
        print(f"Creating {path}")
        os.makedirs(path)


for file in file_list:
    _, ext = os.path.splitext(file)
    ext = ext.lower()
    for file_type in file_extensions.keys():
        try:
            if ext in file_extensions[file_type]:
                source_path = base_path + file
                destination_path = file_paths[file_type]
                if not os.path.exists(destination_path):
                    os.makedirs(destination_path)
                shutil.move(source_path, destination_path)
                break
        except:
            continue
