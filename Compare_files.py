import hashlib

def compare_files(file1, file2):
    # Open the first file in binary mode
    with open(file1, "rb") as f1:
        # Calculate the hash of the first file
        hash1 = hashlib.sha256()
        while True:
            data = f1.read(4096)
            if not data:
                break
            hash1.update(data)
    
    # Open the second file in binary mode
    with open(file2, "rb") as f2:
        # Calculate the hash of the second file
        hash2 = hashlib.sha256()
        while True:
            data = f2.read(4096)
            if not data:
                break
            hash2.update(data)

    # Compare the hashes of the two files
    if hash1.hexdigest() == hash2.hexdigest():
        print("The contents of the two files are the same.")
    else:
        print("The contents of the two files are different.")


compare_files(r"file1.txt", r"file2.txt")
