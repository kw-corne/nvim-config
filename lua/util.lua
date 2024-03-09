local Util = {}

function Util.read_file_sync(path)
	local uv = vim.uv

	local fd = assert(uv.fs_open(path, "r", 438))
	local stat = assert(uv.fs_fstat(fd))
	local data = assert(uv.fs_read(fd, stat.size, 0))

	assert(uv.fs_close(fd))

	return data
end

function Util.extend_tbl(default, opts)
	opts = opts or {}
	return default and vim.tbl_deep_extend("force", default, opts) or opts
end

Util.virtual_text_on = true
function Util.toggle_diagnostic_virtual_text()
	Util.virtual_text_on = not Util.virtual_text_on
	vim.diagnostic.config({ virtual_text = Util.virtual_text_on })
end

function Util.toggle_word_wrap()
	vim.o.wrap = not vim.o.wrap
end

return Util
