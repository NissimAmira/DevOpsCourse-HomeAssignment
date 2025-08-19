import getpass

def main():
	username = getpass.getuser()
	print(f"Current user: {username}")

if __name__ == "__main__":
	main()
