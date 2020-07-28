function [fr] = processFrame(obj, fr)

if size(fr,1) > 1088
    fr = fr(1:1088,:,:);
end

fr(:,:,1) = fr(:,:,2);
fr = rgb2gray(fr);
fr = flip(fr ,1);

end

