parameters{
	SQLCommand as string,
	WhereValue as string,
	FileName as string
}
source(allowSchemaDrift: true,
	validateSchema: false,
	isolationLevel: 'READ_UNCOMMITTED',
	query: ("{$SQLCommand}'{$WhereValue}'"),
	format: 'query') ~> srcSQL
srcSQL sink(allowSchemaDrift: true,
	validateSchema: false,
	format: 'parquet',
	partitionFileNames:[($FileName)],
	umask: 0022,
	preCommands: [],
	postCommands: [],
	skipDuplicateMapInputs: true,
	skipDuplicateMapOutputs: true,
	partitionBy('hash', 1)) ~> dstLake