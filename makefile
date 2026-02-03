# Installation setup steps
bootstrap:
	mix deps.get &&\
	mix assets.setup &&\
	mix deps.compile &&\
	mix ecto.create &&\
	mix ecto.migrate

# Run all checks
check:
	mix format &&\
	mix excellent_migrations.check_safety &&\
	mix recode &&\
	mix coveralls &&\
	mix credo --strict 
