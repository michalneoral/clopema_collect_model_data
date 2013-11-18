smallest = 5.0;
for i=1:44
    A=multiplayer( msgs, i);
    if abs(A(3,2)) < abs(smallest)
        smallest=A(3,2);
        small_pos=i;
    end
    clear A;
end