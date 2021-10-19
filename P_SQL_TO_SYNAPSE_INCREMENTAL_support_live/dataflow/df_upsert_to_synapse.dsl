parameters{
	FolderName as string,
	upsert_key_column as string
}
source(allowSchemaDrift: true,
	validateSchema: false,
	ignoreNoFilesFound: false,
	format: 'parquet',
	wildcardPaths:[($FolderName)]) ~> srcLake
srcLake alterRow(upsertIf(true())) ~> AlterRow
AlterRow sink(allowSchemaDrift: true,
	validateSchema: false,
	deletable:false,
	insertable:false,
	updateable:false,
	upsertable:true,
	keys:[($upsert_key_column)],
	format: 'table',
	staged: true,
	allowCopyCommand: true,
	skipDuplicateMapInputs: true,
	skipDuplicateMapOutputs: true,
	errorHandlingOption: 'stopOnFirstError') ~> dstSynapse