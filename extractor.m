addpath('IRAPT/IRAPT_web');
addpath('Perturbation_analysis');

filename = 'extract/data/sound.wav';

[s,fs] = audioread(filename);

s = s(:,1);
[Fo, ~, time_marks] = irapt(s, fs, 'irapt1','sustain phonation');
Fo_mean = mean(Fo);
Fo_std = std(Fo);

[Fo_periods] = WM_phase_const(s,Fo,time_marks,fs);
J_loc = shim_local(Fo_periods);
J_rap = jitter_rap(Fo_periods);
J_ppq5 = jitter_ppq5(Fo_periods);
J_apq55 = shimmer_apq(Fo_periods,55);
J_absolute = jitter_absolute(Fo_periods);
J_ddp = 3 * J_rap;

[periods_Amp] = amp_extract(Fo_periods,s);
S_loc = shim_local(periods_Amp);
S_apq3 = shim_apq3(periods_Amp);
S_apq5 = shim_apq5(periods_Amp);
S_apq11 = shim_apq11(periods_Amp);
S_apq55 = shimmer_apq(periods_Amp,55);
S_local_db = shim_local_db(periods_Amp);
S_dda = 3 * S_apq3;

PVI = pathology_vibrato(Fo,time_marks(2),196,8);
PPF = pitch_petrurbation_factor(Fo_periods,fs);
DPF = directional_petrurbation_factor(Fo_periods);
PPE = pitch_period_entropy(Fo);

[Hp_mean, Hp_SD, RelHp] = harmonics_analysis(s, Fo_periods);

% store
result = containers.Map;

result('Jitter.local') = J_loc;
result('Jitter.RAP') = J_rap;
result('Jitter.PPQ5') = J_ppq5;
result('Jitter.APQ55') = J_apq55;
result('Jitter.absolute') = J_absolute;
result('Jitter.DDP') = J_ddp;

result('Shimmer.local') = S_loc;
result('Shimmer.APQ3') = S_apq3;
result('Shimmer.APQ5') = S_apq5;
result('Shimmer.APQ11') = S_apq11;
result('Shimmer.APQ55') = S_apq55;
result('Shimmer.DDA') = S_dda;
result('Shimmer.local_db') = S_local_db;

result('PVI') = PVI;
result('PPF') = PPF;
result('DPF') = DPF;
result('PPE') = PPE;

result('Hp.mean.1') = Hp_mean(1);
result('Hp.SD.1') = Hp_SD(1);
result('RelHp.1') = RelHp(1);

result('Fo.mean') = Fo_mean;
result('Fo.std') = Fo_std;

results_json = jsonencode(result);
fid = fopen('extract/result/features.json', 'w');
if fid == -1, error('Cannot create JSON file'); end
fwrite(fid, results_json, 'char');
fclose(fid);
