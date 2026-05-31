function [data,chanlocsnew,srate] = EEGpreprocess(data,chanlocs)
EEG = pop_importdata('data',data,'srate',1000,'chanlocs',chanlocs);
EEG = pop_eegfiltnew(EEG,'locutoff',48,'hicutoff',52,'revfilt',1);
EEG = pop_eegfiltnew(EEG,'locutoff',1,'hicutoff',10);
EEG = pop_reref( EEG, {'M1' 'M2'});
EEG = eeg_checkset(EEG);
EEG = pop_rmbase(EEG,[]);
EEG = pop_resample(EEG,100);
chanlocsnew = EEG.chanlocs;
srate = EEG.srate;
data = EEG.data;
clc
end
