set laststatus=2
let g:airline#extensions#tabline#enabled = 0

let g:airline_section_error = airline#section#create_right(['%{g:asyncrun_status}'])
