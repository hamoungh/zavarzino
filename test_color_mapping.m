function test_color_mapping()
p=(0:0.01:1)';
q=(0:0.01:1)';
[X,Y] = meshgrid(p,q);
result = [X(:) Y(:)];
color=color_mapping_function2(result(:,1),result(:,2));   
C=reshape(color,[size(X) 3]);
mesh(X,Y,zeros(size(X)),C);
xlabel('speed'); ylabel('utilization');
end
