local lush = require('lush')
local hsl = lush.hsl

local colors = {
  -- Basic
  bg = hsl("#1a1a19"),
  fg = hsl("#d1d1d1"),
  -- Normal
  black = hsl("#1a1a19"),
  red = hsl("#ff968c"),
  green = hsl("#61957f"),
  yellow = hsl("#ffc591"),
  blue = hsl("#8db4d4").de(30),
  magenta = hsl("#de9bc8"),
  cyan = hsl("#7bb099"),
  white = hsl("#d1d1d1"),
  -- Bright
  bright_black = hsl("#4c4c4b"),
  bright_red = hsl("#ffafa5"),
  bright_green = hsl("#7aae98"),
  bright_yellow = hsl("#ffdeaa"),
  bright_blue = hsl("#a6cded"),
  bright_magenta = hsl("#f7b4e1"),
  bright_cyan = hsl("#94c9b2"),
  bright_white = hsl("#eaeaea"),
  -- Grays
  gray01 = hsl("#222221"),
  gray02 = hsl("#2a2a29"),
  gray03 = hsl("#323231"),
  gray04 = hsl("#3a3a39"),
  gray05 = hsl("#6a6a69"),
  gray06 = hsl("#767675"),
  gray07 = hsl("#b6b6b5"),
  -- Special
  none = "NONE",
}

-- LSP/Linters mistakenly show `undefined global` errors in the spec, they may
-- support an annotation like the following. Consult your server documentation.
---@diagnostic disable: undefined-global
local theme = lush(function()
  return {
    -- The following are the Neovim (as of 0.8.0-dev+100-g371dfb174) highlight
    -- groups, mostly used for styling UI elements.
    -- Comment them out and add your own properties to override the defaults.
    -- An empty definition `{}` will clear all styling, leaving elements looking
    -- like the 'Normal' group.
    -- To be able to link to a group, it must already be defined, so you may have
    -- to reorder items as you go.
    --
    -- See :h highlight-groups
    --
    Normal       { fg = colors.fg, bg = colors.bg }, -- Normal text
    NormalFloat  { Normal, bg = hsl("#000000").li(2) }, -- Normal text in floating windows.
    NormalNC     { Normal, bg = Normal.bg.li(2) }, -- normal text in non-current windows
    Conceal      { fg = colors.fg.da(30), gui = "bold, italic" }, -- Placeholder characters substituted for concealed text (see 'conceallevel')
    CursorLine   { bg = colors.bg.li(4) }, -- Screen-line at the cursor, when 'cursorline' is set. Low-priority if foreground (ctermfg OR guifg) is not set.
    CursorColumn { CursorLine }, -- Screen-column at the cursor, when 'cursorcolumn' is set.
    ColorColumn  { bg = colors.bg.saturation(2).lightness(20) }, -- Columns set with 'colorcolumn'
    Directory    { gui = "bold" }, -- Directory names (and other special names in listings)
    DiffAdd      { bg = colors.green.da(30) }, -- Diff mode: Added line |diff.txt|
    DiffChange   { bg = colors.blue.da(70) }, -- Diff mode: Changed line |diff.txt|
    DiffDelete   { bg = colors.red.de(60).da(40) }, -- Diff mode: Deleted line |diff.txt|
    DiffText     { bg = colors.blue.da(50) }, -- Diff mode: Changed text within a changed line |diff.txt|
    NonText      { fg = colors.bg.li(20) }, -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
    EndOfBuffer  { NonText }, -- Filler lines (~) after the end of the buffer. By default, this is highlighted like |hl-NonText|.
    SpecialKey   { NonText, gui = 'italic' }, -- Unprintable characters: text displayed differently from what it really is. But not 'listchars' whitespace. |hl-Whitespace|
    Whitespace   { NonText }, -- "nbsp", "space", "tab" and "trail" in 'listchars'
    Cursor       { bg = colors.fg.li(20), fg = colors.bg }, -- Character under the cursor
    lCursor      { Cursor, bg = Cursor.bg.da(30) }, -- Character under the cursor when |language-mapping| is used (see 'guicursor')
    CursorIM     { Cursor }, -- Like Cursor, but used when in IME mode |CursorIM|
    TermCursor   { Cursor }, -- Cursor in a focused terminal
    TermCursorNC { lCursor }, -- Cursor in an unfocused terminal
    Error        { fg = colors.red }, -- Any erroneous construct
    ErrorMsg     { Error }, -- Error messages on the command line
    LineNr       { fg = colors.bg.li(30) }, -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
    CursorLineNr { CursorLine, gui = "bold" }, -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
    VertSplit    { fg = LineNr.fg }, -- Column separating vertically split windows
    Folded       { fg = colors.bg.li(64), bg = colors.bg.li(14) }, -- Line used for closed folds
    FoldColumn   { LineNr, gui = "bold" }, -- 'foldcolumn'
    SignColumn   { LineNr }, -- Column where |signs| are displayed
    Search       { fg = colors.fg, bg = colors.yellow.da(74) }, -- Last search pattern highlighting (see 'hlsearch'). Also used for similar items that need to stand out.
    IncSearch    { fg = colors.bg, bg = colors.bright_yellow, gui = "bold" }, -- 'incsearch' highlighting; also used for the text replaced with ":s///c"
    CurSearch    { IncSearch },
    -- Substitute   { }, -- |:substitute| replacement text highlighting
    MatchParen   { fg = IncSearch.bg, gui = "bold" }, -- Character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
    -- ModeMsg      { }, -- 'showmode' message (e.g., "-- INSERT -- ")
    -- MsgArea      { }, -- Area for messages and cmdline
    MsgSeparator { VertSplit }, -- Separator for scrolled messages, `msgsep` flag of 'display'
    MoreMsg      { fg = colors.green, gui = "bold" }, -- |more-prompt|
    Pmenu        { NormalFloat }, -- Popup menu: Normal item.
    PmenuSel     { NormalFloat, bg = NormalFloat.bg.li(9)}, -- Popup menu: Selected item.
    PmenuSbar    { NormalFloat, bg = NormalFloat.bg.li(11) }, -- Popup menu: Scrollbar.
    PmenuThumb   { NormalFloat, bg = NormalFloat.bg.li(30) }, -- Popup menu: Thumb of the scrollbar.
    Question     { MoreMsg }, -- |hit-enter| prompt and yes/no questions
    -- QuickFixLine { }, -- Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
    SpellBad     { fg = colors.red, gui = "undercurl" }, -- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
    SpellCap     { fg = colors.red, gui = "undercurl" }, -- Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
    SpellLocal   { fg = colors.red, gui = "undercurl" }, -- Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
    SpellRare    { fg = colors.red, gui = "undercurl" }, -- Word that is recognized by the spellchecker as one that is hardly ever used. |spell| Combined with the highlighting used otherwise.
    StatusLine   { Normal, bg = colors.bg.li(6) }, -- Status line of current window
    StatusLineNC { Normal, bg = colors.bg.li(10), gui = "italic" }, -- Status lines of not-current windows. Note: If this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
    TabLine      { StatusLine }, -- Tab pages line, not active tab page label
    TabLineFill  { StatusLineNC }, -- Tab pages line, where there are no labels
    TabLineSel   { gui = "bold" }, -- Tab pages line, active tab page label
    Title        { fg = colors.blue, gui = "bold" }, -- Titles for output from ":set all", ":autocmd" etc.
    Visual       { bg = colors.cyan.da(78) }, -- Visual mode selection
    -- VisualNOS    { }, -- Visual mode selection when vim is "Not Owning the Selection".
    WarningMsg   { fg = colors.yellow }, -- Warning messages
    Winseparator { VertSplit }, -- Separator between window splits. Inherts from |hl-VertSplit| by default, which it will replace eventually.
    WildMenu     { fg = colors.bg, bg = colors.yellow.li(30).da(60) }, -- Current match in 'wildmenu' completion

    -- Common vim syntax groups used for all kinds of code and markup.
    -- Commented-out groups should chain up to their preferred (*) group
    -- by default.
    --
    -- See :h group-name
    --
    -- Uncomment and edit if you want more specific syntax highlighting.

    Comment        { fg = colors.bg.li(32), gui = "italic" }, -- Any comment

    Constant       { fg = colors.bright_cyan }, -- (*) Any constant
    -- String         {  }, --   A string constant: "this is a string"
    -- Character      { }, --   A character constant: 'c', '\n'
    -- Number         { }, --   A number constant: 234, 0xff
    -- Boolean        { }, --   A boolean constant: TRUE, false
    -- Float          { }, --   A floating point constant: 2.3e10

    Identifier     { fg = colors.fg }, -- (*) Any variable name
    Function       { }, --   Function name (also: methods for classes)

    Statement      { fg = colors.blue, gui = "bold" }, -- (*) Any statement
    -- Conditional    { }, --   if, then, else, endif, switch, etc.
    -- Repeat         { }, --   for, do, while, etc.
    -- Label          { }, --   case, default, etc.
    Operator       { fg = colors.bright_yellow }, --   "sizeof", "+", "*", etc.
    -- Keyword        { }, --   any other keyword
    -- Exception      { }, --   try, catch, throw

    PreProc        { Statement }, -- (*) Generic Preprocessor
    -- Include        { }, --   Preprocessor #include
    -- Define         { }, --   Preprocessor #define
    -- Macro          { }, --   Same as Define
    -- PreCondit      { }, --   Preprocessor #if, #else, #endif, etc.

    Type           { fg = colors.yellow.da(10) }, -- (*) int, long, char, etc.
    -- StorageClass   { }, --   static, register, volatile, etc.
    -- Structure      { }, --   struct, union, enum, etc.
    -- Typedef        { }, --   A typedef

    Special        { fg = colors.bg.li(40) }, -- (*) Any special symbol
    -- SpecialChar    { }, --   Special character in a constant
    -- Tag            { }, --   You can use CTRL-] on this
    Delimiter      { Special }, --   Character that needs attention
    SpecialComment { Comment, gui = "NONE" }, --   Special things inside a comment (e.g. '\n')
    -- Debug          { }, --   Debugging statements

    Underlined     { gui = "underline" }, -- Text that stands out, HTML links
    Bold           { gui = "bold" },
    Italic         { gui = "italic" },
    -- Ignore         { }, -- Left blank, hidden |hl-Ignore| (NOTE: May be invisible here in template)
    Todo           { gui = "bold, underline" }, -- Anything that needs extra attention; mostly the keywords TODO FIXME and XXX

    -- These groups are for the native LSP client and diagnostic system. Some
    -- other LSP clients may use these groups, or use their own. Consult your
    -- LSP client's documentation.

    -- See :h lsp-highlight, some groups may not be listed, submit a PR fix to lush-template!
    --
    LspReferenceText            { ColorColumn } , -- Used for highlighting "text" references
    LspReferenceRead            { LspReferenceText } , -- Used for highlighting "read" references
    LspReferenceWrite           { LspReferenceText } , -- Used for highlighting "write" references
    LspCodeLens                 { LineNr } , -- Used to color the virtual text of the codelens. See |nvim_buf_set_extmark()|.
    LspCodeLensSeparator        { Delimiter } , -- Used to color the seperator between two or more code lens.
    LspSignatureActiveParameter { gui = "bold, italic" } , -- Used to highlight the active parameter in the signature help. See |vim.lsp.handlers.signature_help()|.

    -- See :h diagnostic-highlights, some groups may not be listed, submit a PR fix to lush-template!
    --
    DiagnosticError            { fg = colors.red } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
    DiagnosticWarn             { fg = colors.bright_yellow } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
    DiagnosticInfo             { fg = colors.bright_green } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
    DiagnosticHint             { fg = colors.bright_blue } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
    DiagnosticVirtualTextError { DiagnosticError, gui = "italic" } , -- Used for "Error" diagnostic virtual text.
    DiagnosticVirtualTextWarn  { DiagnosticWarn, gui = "italic"} , -- Used for "Warn" diagnostic virtual text.
    DiagnosticVirtualTextInfo  { DiagnosticInfo, gui = "italic"} , -- Used for "Info" diagnostic virtual text.
    DiagnosticVirtualTextHint  { DiagnosticHint, gui = "italic"} , -- Used for "Hint" diagnostic virtual text.
    DiagnosticUnderlineError   { DiagnosticError, gui = "underline" } , -- Used to underline "Error" diagnostics.
    DiagnosticUnderlineWarn    { DiagnosticWarn, gui = "underline" } , -- Used to underline "Warn" diagnostics.
    DiagnosticUnderlineInfo    { DiagnosticInfo, gui = "underline" } , -- Used to underline "Info" diagnostics.
    DiagnosticUnderlineHint    { DiagnosticHint, gui = "underline" } , -- Used to underline "Hint" diagnostics.
    -- DiagnosticFloatingError    { } , -- Used to color "Error" diagnostic messages in diagnostics float. See |vim.diagnostic.open_float()|
    -- DiagnosticFloatingWarn     { } , -- Used to color "Warn" diagnostic messages in diagnostics float.
    -- DiagnosticFloatingInfo     { } , -- Used to color "Info" diagnostic messages in diagnostics float.
    -- DiagnosticFloatingHint     { } , -- Used to color "Hint" diagnostic messages in diagnostics float.
    -- DiagnosticSignError        { } , -- Used for "Error" signs in sign column.
    -- DiagnosticSignWarn         { } , -- Used for "Warn" signs in sign column.
    -- DiagnosticSignInfo         { } , -- Used for "Info" signs in sign column.
    -- DiagnosticSignHint         { } , -- Used for "Hint" signs in sign column.

    -- Tree-Sitter syntax groups. Most link to corresponding
    -- vim syntax groups (e.g. TSKeyword => Keyword) by default.
    --
    -- See :h nvim-treesitter-highlights, some groups may not be listed, submit a PR fix to lush-template!
    --
    -- TSAttribute          { } , -- Annotations that can be attached to the code to denote some kind of meta information. e.g. C++/Dart attributes.
    -- TSBoolean            { } , -- Boolean literals: `True` and `False` in Python.
    -- TSCharacter          { } , -- Character literals: `'a'` in C.
    -- TSCharacterSpecial   { } , -- Special characters.
    -- TSComment            { } , -- Line comments and block comments.
    -- TSConditional        { } , -- Keywords related to conditionals: `if`, `when`, `cond`, etc.
    TSConstant           { Constant } , -- Constants identifiers. These might not be semantically constant. E.g. uppercase variables in Python.
    TSConstBuiltin       { Constant } , -- Built-in constant values: `nil` in Lua.
    TSConstMacro         { Constant } , -- Constants defined by macros: `NULL` in C.
    -- TSConstructor        { } , -- Constructor calls and definitions: `{}` in Lua, and Java constructors.
    -- TSDebug              { } , -- Debugging statements.
    -- TSDefine             { } , -- Preprocessor #define statements.
    -- TSError              { } , -- Syntax/parser errors. This might highlight large sections of code while the user is typing still incomplete code, use a sensible highlight.
    -- TSException          { } , -- Exception related keywords: `try`, `except`, `finally` in Python.
    -- TSField              { } , -- Object and struct fields.
    -- TSFloat              { } , -- Floating-point number literals.
    TSFunction           { gui = "NONE" } , -- Function calls and definitions.
    TSFuncBuiltin        { } , -- Built-in functions: `print` in Lua.
    -- TSFuncMacro          { } , -- Macro defined functions (calls and definitions): each `macro_rules` in Rust.
    -- TSInclude            { } , -- File or module inclusion keywords: `#include` in C, `use` or `extern crate` in Rust.
    -- TSKeyword            { } , -- Keywords that don't fit into other categories.
    -- TSKeywordFunction    { } , -- Keywords used to define a function: `function` in Lua, `def` and `lambda` in Python.
    -- TSKeywordOperator    { } , -- Unary and binary operators that are English words: `and`, `or` in Python; `sizeof` in C.
    -- TSKeywordReturn      { } , -- Keywords like `return` and `yield`.
    -- TSLabel              { } , -- GOTO labels: `label:` in C, and `::label::` in Lua.
    -- TSMethod             { } , -- Method calls and definitions.
    -- TSNamespace          { } , -- Identifiers referring to modules and namespaces.
    -- TSNone               { } , -- No highlighting (sets all highlight arguments to `NONE`). this group is used to clear certain ranges, for example, string interpolations. Don't change the values of this highlight group.
    -- TSNumber             { } , -- Numeric literals that don't fit into other categories.
    -- TSOperator           { } , -- Binary or unary operators: `+`, and also `->` and `*` in C.
    -- TSParameter          { } , -- Parameters of a function.
    -- TSParameterReference { } , -- References to parameters of a function.
    -- TSPreProc            { } , -- Preprocessor #if, #else, #endif, etc.
    -- TSProperty           { } , -- Same as `TSField`.
    -- TSPunctDelimiter     { } , -- Punctuation delimiters: Periods, commas, semicolons, etc.
    -- TSPunctBracket       { } , -- Brackets, braces, parentheses, etc.
    -- TSPunctSpecial       { } , -- Special punctuation that doesn't fit into the previous categories.
    -- TSRepeat             { } , -- Keywords related to loops: `for`, `while`, etc.
    -- TSStorageClass       { } , -- Keywords that affect how a variable is stored: `static`, `comptime`, `extern`, etc.
    -- TSString             { } , -- String literals.
    -- TSStringRegex        { } , -- Regular expression literals.
    -- TSStringEscape       { } , -- Escape characters within a string: `\n`, `\t`, etc.
    -- TSStringSpecial      { } , -- Strings with special meaning that don't fit into the previous categories.
    -- TSSymbol             { } , -- Identifiers referring to symbols or atoms.
    TSTag                { Special } , -- Tags like HTML tag names.
    -- TSTagAttribute       { } , -- HTML tag attributes.
    -- TSTagDelimiter       { } , -- Tag delimiters like `<` `>` `/`.
    -- TSText               { } , -- Non-structured text. Like text in a markup language.
    TSStrong             { Bold } , -- Text to be represented in bold.
    TSEmphasis           { Italic } , -- Text to be represented with emphasis.
    TSUnderline          { Underlined } , -- Text to be represented with an underline.
    TSStrike             { gui = "Strikethrough" } , -- Strikethrough text.
    -- TSTitle              { } , -- Text that is part of a title.
    -- TSLiteral            { } , -- Literal or verbatim text.
    -- TSURI                { } , -- URIs like hyperlinks or email addresses.
    -- TSMath               { } , -- Math environments like LaTeX's `$ ... $`
    -- TSTextReference      { } , -- Footnotes, text references, citations, etc.
    -- TSEnvironment        { } , -- Text environments of markup languages.
    -- TSEnvironmentName    { } , -- Text/string indicating the type of text environment. Like the name of a `\begin` block in LaTeX.
    TSNote               { DiagnosticInfo } , -- Text representation of an informational note.
    TSWarning            { DiagnosticWarn } , -- Text representation of a warning note.
    TSDanger             { DiagnosticError } , -- Text representation of a danger note.
    -- TSType               { } , -- Type (and class) definitions and annotations.
    -- TSTypeBuiltin        { } , -- Built-in types: `i32` in Rust.
    TSVariable           { Identifier } , -- Variable names that don't fit into other categories.
    TSVariableBuiltin    { Identifier, gui = "italic" } , -- Variable names defined by the language: `this` or `self` in Javascript.			diffAdded                 { fg = p.leaf },

    markdownTSPunctSpecial  { Special },
    markdownTSStringEscape  { SpecialKey },
    markdownTSTextReference { Identifier, gui = "underline" },
    markdownTSEmphasis      { Italic },
    markdownTSTitle         { Statement },
    markdownTSLiteral       { Type },
    markdownTSURI           { SpecialComment },

    diffAdded            { fg = colors.bright_green },
    diffRemoved          { fg = colors.red },
    diffChanged          { fg = colors.blue },
    diffOldFile          { fg = colors.red, gui = "italic" },
    diffNewFile          { fg = colors.bright_green, gui = "italic" },
    diffFile             { fg = colors.yellow, gui = "bold" },
    diffLine             { fg = colors.magenta, gui = "bold" },
    diffIndexLine        { fg = colors.yellow },

    gitcommitOverflow         { WarningMsg },

    markdownUrl               { markdownTSURI },
    markdownCode              { markdownTSLiteral },
    markdownLinkText          { markdownTSTextReference },
    markdownLinkTextDelimiter { Delimiter },

    helpHyperTextEntry        { gui = "bold" },
    helpHyperTextJump         { Constant },
    helpSpecial               { Type },
    helpOption                { Constant, gui = "italic" },

    GitSignsAdd                      { SignColumn, fg = colors.bright_green },
    GitSignsChange                   { SignColumn, fg = colors.blue },
    GitSignsDelete                   { SignColumn, fg = colors.red },

    TelescopeSelection               { CursorLine, gui = "bold" },
    TelescopeSelectionCaret          { CursorLine, fg = colors.red },
    TelescopeMatching                { fg = colors.yellow, gui = "bold" },
    TelescopeBorder                  { VertSplit },

    CmpItemAbbr                      { fg = colors.bg.li(36) },
    CmpItemAbbrDeprecated            { fg = colors.bg.li(36), gui = "strikethrough" },
    CmpItemAbbrMatch                 { fg = colors.fg, gui = "bold" },
    CmpItemAbbrMatchFuzzy            { fg = colors.fg.da(12), gui = "bold" },
    CmpItemKind                      { fg = colors.bg.li(32) },
    CmpItemMenu                      { fg = colors.bg.li(28) },

    User1               { Bold, bg = StatusLine.bg }
  }
end)

-- Return our parsed theme for extension or use elsewhere.
return theme

-- vi:nowrap
