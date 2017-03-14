start:
	elm app start

test:
	elm app test

setup:
	elm package install -y && (cd tests && elm package install -y)

test-watch:
	elm app test --watch
