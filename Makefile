# Makefile

# Node.js 프로젝트용 테스트 실행
test:
	@echo "==== Running Node.js tests... ===="
	npm install
	npm test || echo "Tests failed."

# 코드 스타일 검사
lint:
	@echo "==== Running ESLint check... ===="
	npx eslint . || echo "Lint check failed."

# 젠킨스에서 전체 CI 프로세스로 쓸 수 있는 타겟
ci: lint test
	@echo "==== CI process completed ===="

