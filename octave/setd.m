% Copyright 2015 Nicolas Melot
%
% This file is part of Freja.
% 
% Freja is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
% 
% Freja is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
% GNU General Public License for more details.
% 
% You should have received a copy of the GNU General Public License
% along with Freja. If not, see <http://www.gnu.org/licenses/>.
%




%    Copyright 2013 Nicolas Melot
%
%    Nicolas Melot (nicolas.melot@liu.se)
%
%
%    This program is free software: you can redistribute it and/or modify
%    it under the terms of the GNU General Public License as published by
%    the Free Software Foundation, either version 3 of the License, or
%    (at your option) any later version.
%
%    This program is distributed in the hope that it will be useful,
%    but WITHOUT ANY WARRANTY; without even the implied warranty of
%    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%    GNU General Public License for more details.
%
%    You should have received a copy of the GNU General Public License
%    along with this program.  If not, see <http://www.gnu.org/licenses/>.
%
% =========================================================================
%
%	Function setd
%
%	Replace the data matrix with the one provided
%	
%	
%	Parameters:
%	table:	The matrix to which (table).
%	matrix:	Matrix replacing data in table. The matrix should have as
%		many columns as the matrix has column names.
%	out:	The table from merged data (table)
%
%	Example:
%	a = {
%	      [1,1] =
%		1 1 3 4
%		1 2 7 8
%		1 1 5 6
%		2 3 3 9
%		2 3 5 5
%		1 2 7 7
%
%	      [1,2] =
%		col1
%		col2
%		col3
%		col4
%
%             [1,3] = {{}(0x0) {}(0x0) {}(0x0) {}(0x0)}
%	}
%	matrix = [
%		7 7 8 2
%		4 5 3 2
%	]
%	b = setd(a, matrix)
%	b = {
%	      [1,1] =
%		7 7 8 2
%		4 5 3 2
%
%	      [1,2] =
%		col1
%		col2
%		col3
%		col4
%
%             [1,3] = {{}(0x0) {}(0x0) {}(0x0) {}(0x0)}
%	}

function out = setd(table, matrix)
	check(table);
	sizem = size(matrix);
	sizem = sizem(2);
	sizec = size(table{2});
	sizec = sizec(2);

	if sizem != sizec
		error(['Matrix line size (' int2str(sizem) ') incompatible with number of columns (' int2str(sizec) ').']);
	end

	out{1} = matrix;
	out{2} = table{2};
	out{3} = table{3};
	out{4} = table{4};
end






