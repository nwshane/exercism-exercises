class BowlingFrame:
    def __init__(self, **kwargs):
        self.first_roll = None
        self.second_roll = None
        self.third_roll = None
        self.is_last_frame = kwargs['is_last_frame']

    def gets_third_roll(self):
        return self.is_last_frame and (self.is_spare() or self.is_strike())

    def remaining_pins(self):
        starting_number = 10

        if not self.gets_third_roll():
            return starting_number - self.get_total_pins()

        if self.second_roll:
            if self.second_roll == starting_number or self.is_spare():
                if self.third_roll:
                    return starting_number - self.third_roll
                else:
                    return starting_number
            else:
                if self.third_roll:
                    return starting_number - (self.third_roll + self.second_roll)


            print('a: ' + str(starting_number - self.second_roll))
            return starting_number - self.second_roll

        if self.first_roll:
            if self.is_strike():
                return starting_number
            else:
                return starting_number - self.first_roll

    def set_next_roll(self, pins):
        if not isinstance(self.first_roll, int):
            print('setting first roll')
            self.first_roll = pins
        elif not isinstance(self.second_roll, int):
            print('setting second roll')
            self.second_roll = pins
        elif not isinstance(self.third_roll, int):
            print('setting third roll')
            self.third_roll = pins

        if self.remaining_pins() < 0:
            raise ValueError('Cannot knock over more than ten pins')

    def is_spare(self):
        return self.first_roll and self.second_roll and not self.is_strike() and self.first_roll + self.second_roll == 10

    def is_strike(self):
        return self.first_roll and self.first_roll == 10

    def get_total_pins(self):
        first_roll = self.first_roll or 0
        second_roll = self.second_roll or 0
        third_roll = self.third_roll or 0
        return first_roll + second_roll + third_roll

    def is_finished(self):
        if self.gets_third_roll():
            if self.third_roll is not None:
                return True
        else:
            if self.is_strike():
                return True

            if self.second_roll is not None:
                return True

        return False


class BowlingGame(object):
    def __init__(self):
        self.frames = []

    def get_next_two_rolls(self, frame_index):
        next_frame = self.frames[frame_index + 1]
        if next_frame.is_strike() and not next_frame.is_last_frame:
            return 10 + self.frames[frame_index + 2].first_roll
        else:
            return next_frame.first_roll + next_frame.second_roll

    def get_next_roll(self, frame_index):
        return self.frames[frame_index + 1].first_roll

    def get_frame_score(self, frame_index):
        frame = self.frames[frame_index]

        if (frame.is_last_frame):
            return frame.get_total_pins()

        if (frame.is_spare()):
            return frame.get_total_pins() + self.get_next_roll(frame_index)

        if (frame.is_strike()):
            return frame.get_total_pins() + self.get_next_two_rolls(frame_index)

        return frame.get_total_pins()

    def get_frame_scores(self):
        frame_scores = []

        for index, frame in enumerate(self.frames):
            frame_scores.append(self.get_frame_score(index))

        return frame_scores

    def get_frame_pins(self):
        return map(lambda frame: frame.get_total_pins(), self.frames)

    def roll(self, pins):
        print('frames: ' + str(self.get_frame_pins()))
        if len(self.frames) == 10 and self.frames[-1].is_finished():
            raise IndexError('Cannot play more than 10 bowling rounds')

        if pins < 0:
            raise ValueError('Cannot knock over negative pins')

        if len(self.frames) == 0 or self.frames[-1].is_finished():
            self.frames.append(BowlingFrame(is_last_frame=len(self.frames) == 9))

        self.frames[-1].set_next_roll(pins)

    def score(self):
        if len(self.frames) != 10 or not self.frames[-1].is_finished():
            raise IndexError('Cannot score incomplete game')

        return reduce(lambda x, y: x + y, self.get_frame_scores())
